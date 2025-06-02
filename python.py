import psutil
import smtplib
from email.message import EmailMessage

THRESHOLD = 80  # CPU threshold in percentage

def send_alert(cpu_usage):
    msg = EmailMessage()
    msg.set_content(f"High CPU Usage Detected: {cpu_usage}%")
    msg['Subject'] = 'CPU Usage Alert'
    msg['From'] = 'admin@example.com'
    msg['To'] = 'ops-team@example.com'

    with smtplib.SMTP('smtp.example.com', 587) as server:
        server.starttls()
        server.login('admin@example.com', 'your-password')
        server.send_message(msg)

def monitor():
    cpu = psutil.cpu_percent(interval=3)
    if cpu > THRESHOLD:
        send_alert(cpu)
    else:
        print(f"CPU Usage Normal: {cpu}%")

if _name_ == "_main_":
    monitor()
