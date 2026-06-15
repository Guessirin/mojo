from python import Python

fn main() raises:
    # Initialize Pygame using Mojo's Python integration
    let pygame = Python.import_module("pygame")
    let math = Python.import_module("math")

    pygame.init()

    # Window settings
    let width = 800
    let height = 600
    let screen = pygame.display.set_mode((width, height))
    pygame.display.set_caption("3D Cube in Mojo + Pygame")
    
    let clock = pygame.time.Clock()

    # Define 3D vertices of a cube
    # Each vertex is [x, y, z]
    let vertices = [
        [-1, -1, -1],
        [1, -1, -1],
        [1, 1, -1],
        [-1, 1, -1],
        [-1, -1, 1],
        [1, -1, 1],
        [1, 1, 1],
        [-1, 1, 1]
    ]

    # Define the 12 edges of the cube connecting the vertices
    let edges = [
        [0, 1], [1, 2], [2, 3], [3, 0],
        [4, 5], [5, 6], [6, 7], [7, 4],
        [0, 4], [1, 5], [2, 6], [3, 7]
    ]

    # Initial rotation angles
    var angle_x: Float64 = 0.0
    var angle_y: Float64 = 0.0

    # Game Loop
    var running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        # Fill background with black
        screen.fill((0, 0, 0))

        # Rotate and project vertices
        var projected_vertices: List[List[Float64]] = []
        for v in vertices:
            let x = Float64(v[0])
            let y = Float64(v[1])
            let z = Float64(v[2])

            # Rotation around Y axis
            let x1 = x * math.cos(angle_y) - z * math.sin(angle_y)
            let z1 = x * math.sin(angle_y) + z * math.cos(angle_y)
            
            # Rotation around X axis
            let y2 = y * math.cos(angle_x) - z1 * math.sin(angle_x)
            let z2 = y * math.sin(angle_x) + z1 * math.cos(angle_x)

            # Perspective projection (distance from camera = 3.5)
            let distance = 3.5
            let z_proj = distance + z2
            let proj_x = (x1 * (width / 2) / z_proj) + (width / 2)
            let proj_y = (y2 * (height / 2) / z_proj) + (height / 2)

            projected_vertices.append([proj_x, proj_y])

        # Draw edges
        for edge in edges:
            let p1_idx = Int(edge[0])
            let p2_idx = Int(edge[1])
            let p1 = projected_vertices[p1_idx]
            let p2 = projected_vertices[p2_idx]
            
            let start_pos = (Int(p1[0]), Int(p1[1]))
            let end_pos = (Int(p2[0]), Int(p2[1]))
            pygame.draw.line(screen, (0, 255, 0), start_pos, end_pos, 2)

        # Update angles for continuous rotation
        angle_x += 0.01
        angle_y += 0.02

        pygame.display.flip()
        clock.tick(60)

    pygame.quit()
