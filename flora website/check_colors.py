
import os
from PIL import Image
import numpy as np

def get_bg_color(image_path):
    try:
        img = Image.open(image_path).convert('RGB')
        # Get top-left pixel color
        pixel = img.getpixel((0, 0))
        return '#{:02x}{:02x}{:02x}'.format(*pixel)
    except Exception as e:
        return f"Error: {e}"

folder_path = r"c:\Users\Lenovo\Desktop\flora website\flora website\assets\images\products"

# The standard reference
reference_file = "gas-cylinder-9kg.png"
reference_path = os.path.join(folder_path, reference_file)
golden_color = get_bg_color(reference_path)

print(f"Reference Image: {reference_file}")
print(f"Golden Standard Color: {golden_color}")
print("-" * 30)

files_to_check = [
    "gas-cylinder-9kg.png",
    "gas-cylinder-19kg.png",
    "gas-cylinder-48kg.png",
    "gas-stove-2-plate.png",
    "gas-stove-4-plate.png",
    "mobile-gas-heater.png",
    "gas-regulator.png",
    "hose-pipe.png",
    "gas-geyser-12l.png",
    "gas-geyser-16l.png",
    "camping-gas-bottle.png",
    "gas-burner-ring.png",
    "gas-leak-detector.png",
    "industrial-valve.png",
    "gas-cage.png"
]

for filename in files_to_check:
    file_path = os.path.join(folder_path, filename)
    if os.path.exists(file_path):
        bg_color = get_bg_color(file_path)
        status = "MATCH" if bg_color == golden_color else "MISMATCH"
        print(f"{filename}: {bg_color} [{status}]")
    else:
        print(f"{filename}: Not Found")
