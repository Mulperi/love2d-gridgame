require "grid"
require "terrain"
require "cursor"
require "player"

function Game()
    return {
        debug = false,
        player = nil,
        grid = nil,
        terrain = nil,
        cursor = nil,
        moveMode = nil,
        time = 12,
        day = true,
        init = function(self, tileSize, gridLength)
            self.player = PlayerCreate()
            self.grid = GridCreate()
            self.terrain = TerrainCreate()
            self.cursor = CursorCreate()
            self.grid:init(TileSize, GridLength)
            self.player:init({ x = 8, y = 8 }, { 0, 0, 1 })
            self.terrain:generate(self.grid.cells, 2)
            self.moveMode = "player"
            self.day = true
            self.time = 12
        end,
        tick = function(self)
            -- Day/night rotation.
            if self.time > 6 and self.time < 21 then
                self.day = true
            elseif self.time > 20 then
                self.day = false
            end

            -- Time 24h rotation.
            if self.time < 24 then
                self.time = self.time + 1
            else
                self.time = 0
            end

            print(self.day)
        end,
        keypressed = function(self, key)
            if self.moveMode == "cursor" then
                self.cursor:keypressed(key, #self.grid.cells)
            end
            if self.moveMode == "player" then
                self.player:keypressed(key, self.grid)
            end
            if key == "up"
                or key == "right"
                or key == "down"
                or key == "left"
            then
                if self.cursor.selected then
                    self.grid:findPath(self.cursor.selected.x, self.cursor.selected.y, self.cursor.pos.x,
                        self.cursor.pos.y)
                end
                if self.moveMode == "player" then
                    -- Player movement selected so update everything when player moves.
                    self:tick()
                end
            end

            if key == "escape" then
                print(self.moveMode)
                if self.moveMode == "cursor" then
                    self.moveMode = "player"
                else
                    self.moveMode = "cursor"
                end
            end

            if key == "space" then
                self.grid:init(TileSize, GridLength)
                self.terrain:generate(self.grid.cells, 2)
                self.cursor.selected = nil
            end
        end,
        update = function(self, dt)
        end,
        draw = function(self, dt)
            self.terrain:draw(self.grid.cells, self.grid.tileSize, self.day)
            self.grid:draw(self.debug)
            self.player:draw(self.grid.tileSize)
            self.cursor:draw(self.grid)


            -- Time.
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.print(self.time, 0, 0)
        end
    }
end

return Game()
