from python import Python

fn main() raises:
    # 1. Initialize Pygame via Python Interop
    let pygame = Python.import_module("pygame")
    let p = pygame.locals
    
    _ = pygame.init()
    
    # 2. Setup the Screen
    let screen_size = (800, 600)
    let screen = pygame.display.set_mode(screen_size)
    _ = pygame.display.set_caption("Mojo + Pygame Triangle")
    
    # 3. Define Triangle Vertices
    let red = (255, 0, 0)
    let green = (0, 255, 0)
    let blue = (0, 0, 255)
    
    let point_a = (400, 100)
    let point_b = (100, 500)
    let point_c = (700, 500)

    # 4. Main Game Loop
    var running = True
    while running:
        # Event Handling
        for event in pygame.event.get():
            if event.type == p.QUIT:
                running = False
        
        # Clear screen with black
        _ = screen.fill((0, 0, 0))
        
        # Draw the triangle (Pygame expects a list of points and width/line-thickness)
        let points = [point_a, point_b, point_c]
        _ = pygame.draw.polygon(screen, red, points, 0)
        
        # Draw additional vertices or lines
        _ = pygame.draw.aalines(screen, green, True, points)

        _ = pygame.display.flip()
        
    _ = pygame.quit()
