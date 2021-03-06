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



<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Register.ascx.cs" Inherits="Controls_Register" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<style type="text/css">
    .style1
    {
        width: 160px;
        text-align:right;
    }
</style>
<script type="text/javascript">
    function ValidateChecked(oSrc, args) {
        var checked = $(oSrc).siblings().find(':checked').val();
        if (checked != "on" ) {
            args.IsValid = false;
        }
    }
</script>
<asp:MultiView ID="MultiView1" runat="server">
    <asp:View runat="server" ID="DefaultView">
        Enter this code in the box below:
        <br />
        <br />
        <asp:Image ID="CaptchaImage" runat="server" ImageUrl="~/styles/images/Captcha.aspx" ToolTip="Captcha Image" />
        <br />
        <asp:Panel ID="CaptchaPanel" runat="server" DefaultButton="CaptchaSubmitButton">
        <br />
            <asp:TextBox ID="CaptchaCodeTextBox" runat="server" Width="110px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                ControlToValidate="CaptchaCodeTextBox" ValidationGroup="CaptchaControls"></asp:RequiredFieldValidator>
                
            <asp:Button ID="CaptchaSubmitButton" runat="server" ValidationGroup="CaptchaControls"
                Text="Submit" OnClick="CaptchaSubmitButton_Click" />
        </asp:Panel>
        <br />
        Can't read this one?
        <asp:HyperLink ID="ReloadHyperLink" CssClass="Hyperlink" runat="server" ToolTip="Get a new code">Get a new code</asp:HyperLink>
    </asp:View>
    <asp:View runat="server" ID="RegisterView">
        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" FinishDestinationPageUrl="~/Default.aspx"
            OnCreatingUser="CreateUserWizardStep1_CreatingUser" NavigationStyle-HorizontalAlign="Center"
            OnCreatedUser="CreateUserWizardStep1_CreatedUser" OnCreateUserError="CreateUserWizardStep1_CreateUserError">
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                    <ContentTemplate>
                        <table border="0" style="width: 400px">
                            <tr>
                                <td colspan="2">
                                    <div class="ListTitle" style="width: 390px; text-align: center;">
                                        Create an Account</div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:LinkButton runat="server" ID="OpenIdSwitch" Text="Create Account With OpenID" OnClick="SwitchToOpenId" CssClass="Hyperlink"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style1">
                                    <asp:Label ID="FirstNameLabel" runat="server" AssociatedControlID="Email">
                                        First Name<span class="Red">*</span>:
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="FirstName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstName"
                                        ErrorMessage="First Name is required." ToolTip="First Name is required." ValidationGroup="CreateUserWizard1"
                                        SetFocusOnError="true" Display="None" />
                                    <ajax:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" HighlightCssClass="ValidatorCallOutStyle"
                                        Width="150px" TargetControlID="FirstNameRequired" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style1">
                                    <asp:Label ID="LastNameLabel" runat="server" AssociatedControlID="LastName">
                                        Last Name<span class="Red">*</span>:
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="LastName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="LastNameRequired" runat="server" ControlToValidate="LastName"
                                        ErrorMessage="Last Name is required." ToolTip="Last Name is required." ValidationGroup="CreateUserWizard1"
                                        SetFocusOnError="true" Display="None" />
                                    <ajax:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server" HighlightCssClass="ValidatorCallOutStyle"
                                        Width="150px" TargetControlID="LastNameRequired" />
                                </td>
                            </tr>
                            <tr runat="server" id="UserNameTableRow" visible="false">
                                <td align="right" class="style1">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">
                                        User Name<span class="Red">*</span>:
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                        ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUserWizard1"
                                        SetFocusOnError="true" Display="None" />
                                    <ajax:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server" HighlightCssClass="ValidatorCallOutStyle"
                                        Width="150px" TargetControlID="UserNameRequired" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style1">
                                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">
                                        E-mail<span class="Red">*</span>:
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                        ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1"
                                        SetFocusOnError="true" Display="None" />
                                    <ajax:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="server" HighlightCssClass="ValidatorCallOutStyle"
                                        Width="150px" TargetControlID="EmailRequired" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style1">
                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">
                                        Password<span class="Red">*</span>:
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="Password" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                        ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1"
                                        SetFocusOnError="true" Display="None" />
                                    <ajax:ValidatorCalloutExtender ID="ValidatorCalloutExtender5" runat="server" HighlightCssClass="ValidatorCallOutStyle"
                                        Width="150px" TargetControlID="PasswordRequired" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                        ControlToValidate="ConfirmPassword" ErrorMessage="The Password and Confirmation Password must match."
                                        ValidationGroup="CreateUserWizard1" SetFocusOnError="true" Display="None" />
                                    <ajax:ValidatorCalloutExtender ID="ValidatorCalloutExtender6" runat="server" HighlightCssClass="ValidatorCallOutStyle"
                                        Width="150px" TargetControlID="PasswordCompare" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style1">
                                    <asp:Label style="width: 30px" ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">
                                        Confirm Password<span class="Red">*</span>:
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                        ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required."
                                        ValidationGroup="CreateUserWizard1" SetFocusOnError="true" Display="None" />
                                    <ajax:ValidatorCalloutExtender ID="ValidatorCalloutExtender7" runat="server" HighlightCssClass="ValidatorCallOutStyle"
                                        Width="150px" TargetControlID="ConfirmPasswordRequired" />
                                </td>
                            </tr>
                            <tr>
                            
                            <td class="style1" >
                                <asp:Label style="text-align: left;" ID="TermsOfServiceLabel" runat="server">I have read and agree to the <a href="Legal.aspx#TOS" target="_blank">Terms of Service</a> and <a href='Legal.aspx#EUA' target="_blank">End User Agreement</a></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox style="margin-left: 20px; vertical-align: top;" ID="TermsOfServiceCheckbox" runat="server" />
                                <asp:CustomValidator ID="tosValidator" style="display: inline-block; width: 185px;" ValidationGroup="CreateUserWizard1" SetFocusOnError="true" ClientValidationFunction="ValidateChecked" 
                                   runat="server" ErrorMessage="You must agree to the ToS and Privacy Policy to continue" OnServerValidate="ValidateAgreementsCheckbox"></asp:CustomValidator>                               
                            </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="color: Red;">
                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                </asp:CompleteWizardStep>
            </WizardSteps>
            <StartNavigationTemplate>
                <asp:Button ID="StartNextButton" runat="server" CommandName="MoveNext" Text="Next" />
            </StartNavigationTemplate>
            <NavigationStyle HorizontalAlign="Center" />
        </asp:CreateUserWizard>
    </asp:View>
    <asp:View runat="server" ID="OpenIdCreationView">
        <asp:CreateUserWizard ID="CreateOpenIDWizard" RequireEmail="False" AutoGeneratePassword="True"
            runat="server" FinishDestinationPageUrl="~/Default.aspx" NavigationStyle-HorizontalAlign="Center"
            OnCreatedUser="CreateUserWizardStep1_CreatedUser" OnCreateUserError="CreateOpenIdUserWizardStep1_CreateUserError"
            MembershipProvider="OpenIDMembershipProvider">
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep2" runat="server">
                    <ContentTemplate>
                        <table border="0" class="textImag">
                            <tr>
                                <td colspan="2">
                                    <div class="ListTitle" style="width: 390px; text-align: center;">
                                        Create an Account</div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">OpenID:</asp:Label>
                                </td>
                                <td style="height: 26px">
                                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                        ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateOpenIDWizard">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                                        <td class="style1" >
                                <asp:Label style="text-align: left;" ID="TermsOfServiceLabel" runat="server">I have read and agree to the <a href="ToS.html" target="_blank">Terms of Service</a> and <a href='#'>Privacy Policy</a></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox style="margin-left: 20px; vertical-align: top;" ID="TermsOfServiceCheckbox" runat="server" />

                                <asp:CustomValidator ID="tosValidator" style="display: inline-block; width: 185px;" ValidationGroup="CreateOpenIDWizard" SetFocusOnError="true" ClientValidationFunction="ValidateChecked" 
                                   runat="server" ErrorMessage="You must agree to the ToS and Privacy Policy to continue"></asp:CustomValidator>
                                    
                            </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="color: red; height: 22px;">
                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep2" runat="server">
                </asp:CompleteWizardStep>
            </WizardSteps>
            <StartNavigationTemplate>
                <asp:Button ID="StartNextButton" runat="server" CommandName="MoveNext" Text="Next" />
            </StartNavigationTemplate>
            <NavigationStyle HorizontalAlign="Center" />
        </asp:CreateUserWizard>
    </asp:View>
    <asp:View runat="server" ID="ConfirmationView">
        <asp:Label ID="ConfirmationLabel" runat="server">You have successfully created your membership to the ADL 3DR Repository. You will recieve an email once your account is approved. </asp:Label>
        <br />
        <br />
        <asp:Button ID="ConfirmationViewContinueButton" runat="server" OnClick="ConfirmationViewContinueButton_Click"
            Text="Continue" />
        <br />
        <br />
    </asp:View>
    <asp:View runat="server" ID="ErrorView">
        <asp:Label ID="ErrorLabel" runat="server">
            The code you provided was invalid.  Please try again.
        </asp:Label>
        <br />
        <br />
        <asp:Button ID="ErrorContinueButton" runat="server" Text="Continue" ToolTip="Continue"
            CausesValidation="false" OnClick="ErrorContinueButton_Click" />
    </asp:View>
</asp:MultiView>
