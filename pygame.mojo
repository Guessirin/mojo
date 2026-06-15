from python import python

fn main() raises:
    # 1. Import Python's pygame module
    let pg = python.import_module("pygame")

    # 2. Initialize the engine
    pg.init()

    # 3. Create the display surface
    let screen = pg.display.set_mode((800, 600))
    pg.display.set_caption("Mojo 🔥 + Pygame 🎮")

    # 4. Set up the game loop variables
    let clock = pg.time.Clock()
    var running = True

    # 5. Main Game Loop
    while running:
        # Handle game events
        let events = pg.event.get()
        for i in range(len(events)):
            let event = events[i]
            if event.type == pg.QUIT:
                running = False

        # Fill background color (RGB)
        screen.fill((30, 30, 40))

        # Update frame
        pg.display.flip()

        # Limit frame rate to 60 FPS
        _ = clock.tick(60)

    # 6. Clean exit
    pg.quit()
