import json
from pathlib import Path

COLORS = None

with open(Path("./Config/colors.json"), "r") as read_file:
    COLORS = json.load(read_file)