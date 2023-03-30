function PlayerCreate()
    return {
        color = nil,
        pos = nil,
        image = nil,
        init = function(self, pos, color)
            print("player init")
            self.pos = pos
            self.color = color
            self.image = love.graphics.newImage("player.png")
        end,
        keypressed = function(self, key, grid)
            local x = self.pos.x
            local y = self.pos.y
            if key == "up" then
                if self.pos.y > 1 then
                    if not grid.cells[x][y - 1].blocked then
                        self.pos.y = self.pos.y - 1
                    end
                end
            end
            if key == "right" then
                if self.pos.x < #grid.cells
                then
                    if not grid.cells[x + 1][y].blocked then
                        self.pos.x = self.pos.x + 1
                    end
                end
            end
            if key == "down" then
                if self.pos.y < #grid.cells then
                    if not grid.cells[x][y + 1].blocked then
                        self.pos.y = self.pos.y + 1
                    end
                end
            end
            if key == "left" then
                if self.pos.x > 1 then
                    if not grid.cells[x - 1][y].blocked then
                        self.pos.x = self.pos.x - 1
                    end
                end
            end
            if key == "return" then
                if not self.selected then
                    self.selected = {
                        x = self.pos.x,
                        y = self.pos.y
                    }
                else
                    self.selected = nil
                end
            end
        end,
        draw = function(self, tileSize)
            -- Player position.
            -- love.graphics.setColor(self.color[1], self.color[2], self.color[3], 1)
            -- love.graphics.rectangle("fill",
            --     self.pos.x * tileSize - tileSize,
            --     self.pos.y * tileSize - tileSize,
            --     tileSize,
            --     tileSize)
            love.graphics.draw(self.image,
                self.pos.x * tileSize - tileSize,
                self.pos.y * tileSize - tileSize,
                0,
                4, 4
            )
        end
    }
end

return PlayerCreate()
