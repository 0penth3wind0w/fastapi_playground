from typing import Optional
from pydantic import BaseModel

class Something(BaseModel):
    uid: Optional[str] = None
    some_number: int = None
    some_string: str = None

class SomeContent(BaseModel):
    some_number: Optional[int] = None
    some_string: Optional[str] = None