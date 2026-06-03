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
      If you didn’t request this, please ignore this email.
    </p>

    <p style="margin-top:25px; color:#666;">
      Thank you,<br />
      <strong>Mula-pay Team</strong>
    </p>
  </div>
</body>
</html>    
    """
    
    
    




