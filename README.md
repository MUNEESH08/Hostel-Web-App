
Hostel Allocation System - Improved
----------------------------------

This project is an improved version with:
- AC / Non-AC and double/triple filters for room listings.
- Manual CSRF protection.
- Session expiry (30 minutes).
- Role-based decorators for route protection.
- All HTML templates included.

Run:
1. Install requirements: pip install -r requirements.txt
2. Start MongoDB and set MONGO_URI env var if needed.
3. Set COLLEGE_KEY and SECRET_KEY if desired.
4. python app.py
