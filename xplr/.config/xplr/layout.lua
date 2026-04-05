local xplr = xplr

xplr.config.layouts.builtin.default = {
  Horizontal = {
    config = {
      constraints = {
        { Percentage = 50 },
        { Percentage = 50 },
      }
    },
    splits = {
      -- Left side (Table and small Help below)
      {
        Vertical = {
          config = {
            constraints = {
              { Min = 1 },     -- Table takes most space
              { Length = 15 }, -- Help menu is small
              { Length = 1 },  -- Input/Logs
            }
          },
          splits = {
            "Table",
            "HelpMenu",
            "InputAndLogs",
          }
        }
      },
      -- Right side (Preview top, Selection bottom)
      {
        Vertical = {
          config = {
            constraints = {
              { Percentage = 60 }, -- Preview area
              { Percentage = 40 }, -- Selection area
            }
          },
          splits = {
            {
              CustomParagraph = {
                ui = { title = { format = "Preview" } },
                body = "Native image preview requires an external terminal wrapper or multiplexer plugin in xplr.\n\nFor a fully native image preview with this exact layout, 'yazi' is highly recommended."
              }
            },
            "Selection",
          }
        }
      }
    }
  }
}
