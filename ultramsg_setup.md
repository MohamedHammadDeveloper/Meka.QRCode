# UltraMsg Setup & Integration Guide

## 1. Get Instance ID & Token
1. Go to [ultramsg.com](https://ultramsg.com) and create an account.
2. Create an instance and connect your WhatsApp number by scanning the QR code in the UltraMsg dashboard using your phone's WhatsApp Linked Devices.
3. Copy your **Instance ID** (e.g., `instance12345`) and **Token** (e.g., `abc123def456`). Keep these secure.

## 2. Webhook Setup
To receive messages and trigger the n8n Workflow #1 (Incoming Message router):
1. In the UltraMsg dashboard, go to your Instance -> **Settings** -> **Webhook**.
2. Enable "Webhook on received".
3. Enter your **n8n Webhook URL** (e.g., `https://your-n8n-domain.com/webhook/ultramsg-inbound`) which corresponds to the Webhook node in the provided n8n workflows. Make sure it's the Production URL.
4. Set "Webhook setup" to send JSON.
5. Click **Save**.

## 3. Using UltraMsg in n8n
The provided n8n workflows (`n8n_workflows.json`) use the standard **HTTP Request node** to send messages since UltraMsg is fundamentally a REST API wrapper. Here is the reference API call used internally:
- **Method**: POST
- **URL**: `https://api.ultramsg.com/{{$env["ULTRAMSG_INSTANCE_ID"]}}/messages/chat`
- **Headers**:
  - `Content-Type: application/x-www-form-urlencoded`
- **Body Parameters**:
  - `token`: Your UltraMsg token
  - `to`: The user's phone number
  - `body`: The message text dynamically evaluated

## 4. Retries & Error Handling
- The `n8n_workflows.json` ensures messages failed due to external issues are captured. 
- You can configure the **HTTP Request Node** settings in n8n to "Retry On Fail" -> typically 3 retries, exponential backoff.
- The `MessagesLog` handles keeping `Status = 'SENT'` or `Status = 'FAILED'`.
