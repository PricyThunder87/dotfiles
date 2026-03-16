local system = require("pandoc.system")

local function render_mermaid(code)
  return system.with_temporary_directory("mermaid", function(tmpdir)
    local infile = tmpdir .. "/input.mmd"
    local outfile = tmpdir .. "/output.png"

    local f = io.open(infile, "w")
    f:write(code)
    f:close()

    local config = os.getenv("HOME") .. "/.dotfiles/mermaid-config.json"
    local cmd = string.format(
      "mmdc -i %s -o %s -c %s -b transparent -s 4 2>/dev/null",
      infile, outfile, config
    )
    os.execute(cmd)

    -- Read PNG and base64 encode it
    local pipe = io.popen("base64 -w0 " .. outfile .. " 2>/dev/null")
    if not pipe then
      return nil
    end
    local encoded = pipe:read("*all")
    pipe:close()

    if encoded == "" then
      return nil
    end

    return encoded
  end)
end

function CodeBlock(block)
  if block.classes[1] == "mermaid" then
    local b64 = render_mermaid(block.text)
    if b64 then
      return pandoc.RawBlock("html",
        '<div class="mermaid-diagram"><img src="data:image/png;base64,' .. b64 .. '" style="max-width:100%;" /></div>'
      )
    end
  end
end
