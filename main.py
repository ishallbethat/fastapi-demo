from typing import Union
import uptrace
from fastapi import FastAPI
from fastapi_utils.tasks import repeat_every
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import (
    BatchSpanProcessor,
    ConsoleSpanExporter,
)

provider = TracerProvider()
processor = BatchSpanProcessor(ConsoleSpanExporter(service_name="fastapi-demo"))
provider.add_span_processor(processor)

# Sets the global default tracer provider
trace.set_tracer_provider(provider)

# Creates a tracer from the global tracer provider
tracer = trace.get_tracer(__name__)

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
@repeat_every(seconds=10)  
def say_hello() -> None:
  with tracer.start_as_current_span(name="say_hello", record_exception=True, set_status_on_exception=True):
    print("hello world")