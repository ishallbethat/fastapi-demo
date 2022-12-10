install:
	pip install -r requirements.txt
dev-run:
	UPTRACE_DSN=http://project2_secret_token@uptrace.gebi.link:14318/2 uvicorn main:app --host 0.0.0.0 --reload