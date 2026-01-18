import os

path = r"c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"

def move_section():
    if not os.path.exists(path):
        print(f"File not found: {path}")
        return

    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    # Define range to move (0-indexed)
    # Target: 1072 to 1255 (1-based) -> 1071 to 1254 (0-based)
    start_line_1based = 1072
    end_line_1based = 1255
    
    start_idx = start_line_1based - 1
    end_idx = end_line_1based # Slice is exclusive, so this covers up to end_line_1based - 1

    # Extract section
    section = lines[start_idx:end_idx]
    
    print(f"Extracted {len(section)} lines.")
    print(f"First line: {section[0].strip()}")
    print(f"Last line: {section[-1].strip()}")

    # Verify content looks like testimonials
    if "testimonials-one" not in section[0]:
        print("Error: Start line does not look like testimonials section.")
        return

    # Deleting the section
    del lines[start_idx:end_idx]

    # Target insertion (0-indexed)
    # Original target was 1598 (1-based) -> 1597 (0-based)
    # Since we deleted lines before it, adjust index
    original_target_1based = 1598
    original_target_idx = original_target_1based - 1
    
    shift = end_idx - start_idx
    new_target_idx = original_target_idx - shift
    
    print(f"Inserting at new line index: {new_target_idx} (was {original_target_idx})")

    # Insert section
    lines[new_target_idx:new_target_idx] = section

    with open(path, 'w', encoding='utf-8') as f:
        f.writelines(lines)
    
    print("Successfully moved section.")

if __name__ == "__main__":
    move_section()
