-- based on https://forum.obsidian.md/t/rendering-callouts-similarly-in-pandoc/40020/6

local stringify = (require "pandoc.utils").stringify

function BlockQuote (el)
	local type_class_map = {
		  ["note"]    = "alert"
		, ["info"]    = "alert"
		, ["tip"]     = "alert"
		, ["file"]    = "alert"

		, ["warn"]    = "alert warn"
		, ["warning"] = "alert warn"
		, ["caution"] = "alert warn"
		, ["beware"]  = "alert warn"

		, ["err"]     = "alert bad"
		, ["error"]   = "alert bad"
		, ["danger"]  = "alert bad"
		, ["fatal"]   = "alert bad"
	}

	local type_heading_map = {
		  ["note"]    = "Note"
		, ["info"]    = "Info"
		, ["tip"]     = "Tip"
		, ["file"]    = "File"

		, ["warn"]    = "Warning"
		, ["warning"] = "Warning"
		, ["caution"] = "Caution"
		, ["beware"]  = "Beware"

		, ["err"]     = "Error"
		, ["error"]   = "Error"
		, ["danger"]  = "Danger"
		, ["fatal"]   = "Fatal"
	}

    start = el.content[1]
    if (
			    start.t == "Para"
			and start.content[1].t == "Str"
			and start.content[1].text:match("^%[!%w+%][-+]?$")
		) then
		-- ok so all callouts will be implemented as <details> even if they don't need to
		-- be collapsible. remember, default behavior is independent from semantics.
		-- we may choose to hide the marker on callouts that weren't marked as collapsible though
        _, _, callout_type = start.content[1].text:find("%[!(%w+)%]")
				_, _, callout_expansion = start.content[1].text:find("%[!%w+%]([-+]?)")
				defaults_to_open = not (callout_expansion == "-")
				is_collapsible = not (callout_expansion == "")

				classes = type_class_map[callout_type] or "alert"
				open = defaults_to_open and " open" or "" -- goofy ass ternary

				-- <details[ open] class='$classes' data-obsidian-callout-type='$callout_type'>
				--   <summary>[$heading{:] $title}</summary>
				--   $body
				-- </details>

				local heading = type_heading_map[callout_type] or ""
				start.content:remove(1) -- pop the [!info] token probably?
				local title = stringify(start.content):gsub("^ ", "")
				el.content:remove(1) -- pop the title line
				local body = el.content

				local summary = ""
				if #heading > 0 and #title > 0 then
					summary = table.concat({heading, title}, ': ')
				elseif #heading > 0 then
					summary = heading
				elseif #title > 0 then
					summary = title
				end
				if #summary > 0 then summary = "<summary>"..summary.."</summary>" end

				return {
				pandoc.RawBlock("html", "<details" .. open .. " class='" .. classes .. "' data-obsidian-callout-type='" .. callout_type:lower() .. "'>")
				, pandoc.Plain(
						  pandoc.RawInline("html", summary)
						, pandoc.RawInline("html", body)
					)
				, pandoc.RawBlock("html", "</details>")
				}

    else
        return el
    end
end
