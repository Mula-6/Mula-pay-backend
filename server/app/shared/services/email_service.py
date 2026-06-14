from app.core import settings
from mailjet_rest import Client


class EmailService:
    def __init__(self):
        self.mailjet = Client(auth=(settings.MAIL_JET_API, settings.MAIL_JET_SK))
        
    
    async def send_email_otp(self, email: str, otp: str):
        data = {
            "FromEmail": settings.APP_EMAIL_SENDER,
            "FromName": "Mula-pay",
            "Subject": "OTP Verification",
            "Html-part": self.otp_page_data(otp),
            "Recipients": [{"Email": email}],
        }
        result = self.mailjet.send.create(data=data)
        print(result.status_code)
    
    async def send_password_updated_notification(self, email: str, firstname: str = "User"):
        """
        Send notification to user that their password has been updated
        """
        data = {
            "FromEmail": settings.APP_EMAIL_SENDER,
            "FromName": "Mula-pay",
            "Subject": "🔐 Password Updated Successfully",
            "Html-part": self.password_updated_page_data(firstname),
            "Recipients": [{"Email": email}],
        }
        result = self.mailjet.send.create(data=data)
        print(result.status_code)
        return result
    
    def otp_page_data(self, otp: str):
        return f"""
    <!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Email Verification</title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif; background:#f6f8fb; padding:20px;">
  <div style="max-width:600px; margin:0 auto; background:#ffffff; border-radius:10px; padding:25px;">
    <h2 style="color:#0b3d91; margin-bottom:10px;">Verify Your Email</h2>
    <p style="color:#333;">
      Use the One-Time Password (OTP) below to complete your verification.
    </p>

    <div style="text-align:center; margin:25px 0;">
      <span style="display:inline-block; font-size:28px; font-weight:bold; letter-spacing:3px; padding:12px 25px; border-radius:8px; background:#0b3d91; color:#ffffff;">
        {otp}
      </span>
    </div>

    <p style="color:#333;">
      This code is valid for <strong>5 minutes</strong>.  
      If you didn't request this, please ignore this email.
    </p>

    <p style="margin-top:25px; color:#666;">
      Thank you,<br />
      <strong>Mula-pay Team</strong>
    </p>
  </div>
</body>
</html>    
    """
    
    def password_updated_page_data(self, firstname: str):
        return f"""
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Password Updated Successfully</title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif; background:#f6f8fb; padding:20px;">
  <div style="max-width:600px; margin:0 auto; background:#ffffff; border-radius:10px; padding:25px;">
    
    <!-- Success Icon -->
    <div style="text-align:center; margin-bottom:20px;">
      <div style="display:inline-block; width:60px; height:60px; background:#4caf50; border-radius:50%; text-align:center; line-height:60px;">
        <span style="color:#ffffff; font-size:30px;">✓</span>
      </div>
    </div>
    
    <h2 style="color:#0b3d91; text-align:center; margin-bottom:10px;">Password Updated!</h2>
    
    <p style="color:#333; font-size:16px; text-align:center;">
      Hello <strong>{firstname}</strong>,
    </p>
    
    <p style="color:#333; font-size:16px; text-align:center;">
      Your password has been successfully updated.
    </p>
    
    <div style="background:#e8f5e9; border-left:4px solid #4caf50; padding:15px; margin:25px 0; border-radius:4px;">
      <p style="margin:0; color:#2e7d32; font-size:14px;">
        <strong>✓</strong> If you made this change, no further action is required.
      </p>
      <p style="margin:10px 0 0 0; color:#2e7d32; font-size:14px;">
        <strong>⚠️</strong> If you did not change your password, please contact our support team immediately.
      </p>
    </div>
    
    <div style="text-align:center; margin:25px 0;">
      <a href="#" style="display:inline-block; background:#0b3d91; color:#ffffff; text-decoration:none; padding:12px 30px; border-radius:5px; font-weight:bold;">
        Go to Dashboard
      </a>
    </div>
    
    <hr style="border:none; border-top:1px solid #eee; margin:25px 0;" />
    
    <p style="color:#666; font-size:12px; text-align:center;">
      This is an automated message from Mula-pay. Please do not reply to this email.
    </p>
    
    <p style="margin-top:25px; color:#666; font-size:14px; text-align:center;">
      Thank you for trusting,<br />
      <strong>Mula-pay Team</strong>
    </p>
  </div>
</body>
</html>
    """

    async def send_general_message(self, email: str, subject: str, message: str, firstname: str = "User"):
        """
        Send a general message to user
        """
        data = {
            "FromEmail": settings.APP_EMAIL_SENDER,
            "FromName": "Mula-pay",
            "Subject": subject,
            "Html-part": self.general_message_page_data(firstname, message),
            "Recipients": [{"Email": email}],
        }
        result = self.mailjet.send.create(data=data)
        print(result.status_code)
        return result
    
    def general_message_page_data(self, firstname: str, message: str):
        return f"""
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Message from Mula-pay</title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif; background:#f6f8fb; padding:20px;">
  <div style="max-width:600px; margin:0 auto; background:#ffffff; border-radius:10px; padding:25px;">
    
    <!-- Info Icon -->
    <div style="text-align:center; margin-bottom:20px;">
      <div style="display:inline-block; width:60px; height:60px; background:#0b3d91; border-radius:50%; text-align:center; line-height:60px;">
        <span style="color:#ffffff; font-size:30px;">📧</span>
      </div>
    </div>
    
    <h2 style="color:#0b3d91; text-align:center; margin-bottom:10px;">Hello {firstname}!</h2>
    
    <div style="background:#f8f9fa; padding:20px; border-radius:8px; margin:20px 0; line-height:1.6;">
      <p style="color:#333; font-size:16px; margin:0;">
        {message}
      </p>
    </div>
    
    <hr style="border:none; border-top:1px solid #eee; margin:25px 0;" />
    
    <p style="color:#666; font-size:12px; text-align:center;">
      This is an automated message from Mula-pay.
    </p>
    
    <p style="margin-top:25px; color:#666; font-size:14px; text-align:center;">
      Best regards,<br />
      <strong>Mula-pay Team</strong>
    </p>
  </div>
</body>
</html>
    """