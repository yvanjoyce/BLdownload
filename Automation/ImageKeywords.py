from PIL import Image, ImageDraw

def draw_circle_on_screenshot(image_path, x_coord, y_coord, radius, color):
    x_coord = int(x_coord)
    y_coord = int(y_coord)
    radius = int(radius)
    image = Image.open(image_path)
    draw = ImageDraw.Draw(image)
    draw.ellipse([(x_coord - radius, y_coord - radius), (x_coord + radius, y_coord + radius)], outline=color)
    image.save(image_path)
