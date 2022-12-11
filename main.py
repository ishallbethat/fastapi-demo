from typing import Union
import uptrace
from fastapi import FastAPI
from fastapi_utils.tasks import repeat_every
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor

app = FastAPI()

uptrace.configure_opentelemetry(
    # Copy DSN here or use UPTRACE_DSN env var.
    # dsn="",
    service_name="fastapi-demo",
    service_version="1.0.0",
)

@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}

FastAPIInstrumentor.instrument_app(app)


@app.on_event("startup")
@repeat_every(seconds=60)  
def say_hello() -> None:
    print("hello world")