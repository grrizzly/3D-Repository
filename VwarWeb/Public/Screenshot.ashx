<%--
Copyright 2011 U.S. Department of Defense

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--%>



<%@ WebHandler Language="C#" Class="Screenshot" %>

using System.IO;
using System;
using System.Web;
using System.Web.SessionState;
using vwarDAL;
/// <summary>
/// 
/// </summary>
public class Screenshot : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="context"></param>
    public void ProcessRequest(HttpContext context)
    {
        var session = context.Request.QueryString["Session"];
        var ContentObjectID = context.Request.QueryString["ContentObjectID"];
        var Session = context.Session;
        var format = context.Request.QueryString["Format"];
        var tempFilename = context.Request.QueryString["TempArchiveName"];

        if (context.Request.QueryString["temp"] == "true" || ContentObjectID == null)
        {
            if (session == "true")
            {
                using (FileStream stream = new FileStream(context.Server.MapPath("~/App_Data/imageTemp/screenshot_" + tempFilename.Replace(".o3d", ".png").Replace("zip", "png")), FileMode.Open))
                {
                    byte[] buffer = new byte[stream.Length];
                    stream.Read(buffer, 0, (int)stream.Length);
                    context.Response.BinaryWrite(buffer);
                }

                context.Response.End();
            }
            else
            {
                try
                {
                    using (FileStream fs = new FileStream(context.Server.MapPath("~/App_Data/imageTemp/screenshot_" + tempFilename.Replace(".o3d", ".png").Replace("zip", "png")), FileMode.Create))
                    {
                        using (BinaryWriter outwriter = new BinaryWriter(fs))
                        {
                            outwriter.Write(GetDecodedImageBytes(context.Request.InputStream, format));
                        }
                    }
                    return;
                }
                catch
                {
                    return;//the original logic did not have any error handling and worked, so we replicate this here
                }

            }
        }
        else
        {
            ContentObjectID = ContentObjectID.Replace('_', ':');
            


            vwarDAL.IDataRepository dal = (new vwarDAL.DataAccessFactory()).CreateDataRepositorProxy();
            vwarDAL.ContentObject rv = null;
            if(ContentObjectID != null)
                rv = dal.GetContentObjectById(ContentObjectID, false);

            if (ContentObjectID != null)
            {
                vwarDAL.PermissionsManager perm = new PermissionsManager();
                vwarDAL.ModelPermissionLevel level = perm.GetPermissionLevel(HttpContext.Current.User.Identity.Name, ContentObjectID);
                perm.Dispose();
                if (level < vwarDAL.ModelPermissionLevel.Searchable)
                {

                   
                    return;
                }
            }
            
            if (session == "true")
            {
                using (Stream s = dal.GetContentFile(rv.PID, rv.ScreenShotId))
                {
                    byte[] data = new byte[s.Length];
                    s.Read(data, 0, data.Length);
                    context.Response.BinaryWrite(data);
                    
                    return;
                }
            }
            else
            {
                if (String.IsNullOrEmpty(rv.ScreenShot))
                {
                    if (format.Contains("png"))
                        rv.ScreenShot = "screenshot.png";
                    if (format.Contains("jpg"))
                        rv.ScreenShot = "screenshot.jpg";
                }

                byte[] decodedBytes;
                try
                {
                    decodedBytes = GetDecodedImageBytes(context.Request.InputStream, format);
                    using (MemoryStream stream = new MemoryStream())
                    {
                        stream.Write(decodedBytes, 0, decodedBytes.Length);

                        rv.ScreenShotId = dal.SetContentFile(stream, ContentObjectID, rv.ScreenShot);
                        
                        System.Drawing.Imaging.ImageFormat thumbFmt = System.Drawing.Imaging.ImageFormat.Png;
                        string ext = string.Empty; 
                        if (format.Contains("png"))
                        {
                            thumbFmt = System.Drawing.Imaging.ImageFormat.Png;
                            ext = ".png";
                        }
                        else if (format.Contains("jpg"))
                        {
                            thumbFmt = System.Drawing.Imaging.ImageFormat.Jpeg;
                            ext = ".jpg";
                        }
                        else if (format.Contains("gif"))
                        {
                            thumbFmt = System.Drawing.Imaging.ImageFormat.Gif;
                            ext = ".gif";
                        }
                        else
                        {
                            context.Response.StatusCode = 500;
                            context.Response.StatusDescription = "Invalid image format";
                            context.Response.End();
                        }

                        rv.ThumbnailId = Website.Common.GetFileSHA1AndSalt(stream) + ext;
                        
                        using (FileStream outStream = new FileStream(context.Server.MapPath("~/thumbnails/" + rv.ThumbnailId), FileMode.Create))
                            Website.Common.GenerateThumbnail(stream, outStream, thumbFmt);
                    }
                    
                }
                catch
                {
                    return;
                }

                //try to get the file contents. If you could get them, that means it exists and
                //should be updated
                dal.UpdateContentObject(rv);
            }
        }
    }
    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="inputStream"></param>
    /// <param name="format"></param>
    /// <returns></returns>
    private byte[] GetDecodedImageBytes(System.IO.Stream inputStream, string format)
    {
        byte[] bytes = new byte[inputStream.Length];

        inputStream.Read(bytes, 0, bytes.Length);

        System.Text.ASCIIEncoding enc = new System.Text.ASCIIEncoding();
        String str = enc.GetString(bytes);
        byte[] decodedBytes = new byte[0];
        if (str.Length < 22 && format.Contains("png"))
            throw new Exception("Invalid data for PNG");
        if (format.Contains("png"))
            decodedBytes = Convert.FromBase64CharArray(str.Substring(22).ToCharArray(), 0, (int)str.Length - 22);
        if (format.Contains("jpg") )
            decodedBytes = Convert.FromBase64CharArray(str.ToCharArray(), 0, (int)str.Length);
        if (decodedBytes.Length == 0)
            throw new Exception("Image request contains no data");

        return decodedBytes;

    }
    /// <summary>
    /// 
    /// </summary>
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
