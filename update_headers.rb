require 'fileutils'

files = [
  "app/views/health_checks/_health_check.html.erb",
  "app/views/health_checks/_heart.html.erb",
  "app/views/health_checks/_kidney.html.erb",
  "app/views/health_checks/_liver.html.erb",
  "app/views/health_checks/_other.html.erb",
  "app/views/health_checks/_pancreas.html.erb",
  "app/views/health_checks/_stomach.html.erb"
]

files.each do |file|
  content = File.read(file)

  # 1. Update the wrapper div
  # Find <div class="hidden ... lg:block ...">
  content.sub!(/<div class="hidden [^>]*lg:block[^>]*">/) do |match|
    '<div class="hidden lg:block overflow-auto max-h-[70vh] w-full shadow-inner">'
  end

  # 2. Update the table inside that div
  # Since the table is the next element, we can find the first table after the div
  # But simpler: just find the table that has `px-2 w-full` or `mx-auto min-w-full` which is in the desktop view.
  # Let's just find the table right after the new div
  content.sub!(/(<div class="hidden lg:block overflow-auto max-h-\[70vh\] w-full shadow-inner">\s*)<table class="([^"]*)">/) do |match|
    prefix = $1
    classes = $2
    # Ensure classes has border-separate and border-spacing-0
    classes += " border-separate border-spacing-0" unless classes.include?("border-separate")
    "#{prefix}<table class=\"#{classes}\">"
  end

  # 3. Process thead blocks
  # Find all thead blocks
  thead_count = 0
  content.gsub!(/(<thead[^>]*>)(.*?)(<\/thead>)/m) do |match|
    open_tag = $1
    inner = $2
    close_tag = $3
    thead_count += 1

    top_class = thead_count == 1 ? "top-0" : "top-[44px]"

    # Add classes to each th inside this thead
    inner.gsub!(/<th class="([^"]*)"([^>]*)>/) do |th_match|
      existing_classes = $1
      rest = $2

      # Remove existing sticky/bg classes if they happen to exist
      clean_classes = existing_classes.split(" ").reject { |c| c.start_with?("sticky", "top-", "z-", "bg-", "border-b-4", "border-gray-200", "dark:border-gray-800") }.join(" ")

      new_classes = "sticky #{top_class} z-20 bg-gray-100 dark:bg-black border-b-4 border-gray-200 dark:border-gray-800 #{clean_classes}".strip

      "<th class=\"#{new_classes}\"#{rest}>"
    end

    "#{open_tag}#{inner}#{close_tag}"
  end

  File.write(file, content)
  puts "Updated #{file}"
end
