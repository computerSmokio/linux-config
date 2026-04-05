local xplr = xplr

-- Set a custom zip mode
xplr.config.modes.custom.zip = {
  name = "zip",
  key_bindings = {
    on_key = {
      z = {
        help = "zip selection",
        messages = {
          {
            BashExec = [===[
              if [ -s "${XPLR_PIPE_SELECTION_OUT:?}" ]; then
                zip -r archive.zip -@ < "${XPLR_PIPE_SELECTION_OUT:?}"
              else
                zip -r archive.zip "${XPLR_FOCUS_PATH:?}"
              fi
            ]===]
          },
          "PopMode",
        },
      },
      n = {
        help = "zip to named file",
        messages = {
          {
            BashExec = [===[
              read -r -p "Enter zip file name (without .zip): " zipname
              if [ -n "$zipname" ]; then
                if [ -s "${XPLR_PIPE_SELECTION_OUT:?}" ]; then
                  zip -r "$zipname.zip" -@ < "${XPLR_PIPE_SELECTION_OUT:?}"
                else
                  zip -r "$zipname.zip" "${XPLR_FOCUS_PATH:?}"
                fi
              fi
            ]===]
          },
          "PopMode",
        },
      },
      esc = {
        help = "cancel",
        messages = {
          "PopMode",
        },
      },
    },
    default = {
      messages = {
        "PopMode",
      },
    },
  },
}

-- Set a custom batch mode
xplr.config.modes.custom.batch = {
  name = "batch",
  key_bindings = {
    on_key = {
      b = {
        help = "run batch command on selection",
        messages = {
          {
            BashExec = [===[
              read -r -p "Enter command to run on selected files (use {} for file path): " cmd
              if [ -n "$cmd" ]; then
                if [ -s "${XPLR_PIPE_SELECTION_OUT:?}" ]; then
                  cat "${XPLR_PIPE_SELECTION_OUT:?}" | while read -r file; do
                    eval "${cmd//\{\}/\"$file\"}"
                  done
                else
                  eval "${cmd//\{\}/\"${XPLR_FOCUS_PATH:?}\"}"
                fi
                echo "Batch command executed. Press enter to continue."
                read -r
              fi
            ]===]
          },
          "PopMode",
        },
      },
      esc = {
        help = "cancel",
        messages = {
          "PopMode",
        },
      },
    },
    default = {
      messages = {
        "PopMode",
      },
    },
  },
}

-- Bind custom modes to keys in normal mode
xplr.config.modes.builtin.default.key_bindings.on_key.z = {
  help = "zip mode",
  messages = {
    { SwitchModeCustom = "zip" },
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key.b = {
  help = "batch mode",
  messages = {
    { SwitchModeCustom = "batch" },
  },
}
