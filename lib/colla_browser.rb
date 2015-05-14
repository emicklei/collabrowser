require 'win32ole'
require 'colla_client'

man = <<EOM
  Usage:
    collabrowser [host] [nickname] [topic]
  Example:
    collabrowser http://ruby.gijjes.nl raving_ruby_rider rails
EOM
if ARGV.size == 0
  puts man
  # exit
end

$SERVER = ARGV[0] || 'http://ernest.gijjes.nl'
$NICKNAME = ARGV[1] || 'raving_ruby_rider'
$TOPIC = ARGV[2] || 'rails'
$urls = []
$current = nil
$LISTEN = true

puts "Listening to server:#{$SERVER}" 

def navigate(url)
  $urls << url
end

def stop_msg_loop
  puts "Now Stop IE..."
  $LOOP = FALSE;
end

def default_handler(event, *args)
  case event
  when "BeforeNavigate"
    new_url = args[0]
    if $current != new_url
      submit_url($SERVER,$current = new_url)
    end
    puts "be quiet..." 
    $LISTEN = false
  when "NavigateComplete"
    navigate(args[0])
    puts "...listen again"
    $LISTEN = true
  when "Quit"
    stop_msg_loop
  end
  # puts "ie event:#{event}"
end

ie = WIN32OLE.new('InternetExplorer.Application')
ie.visible = TRUE

ev = WIN32OLE_EVENT.new(ie, 'DWebBrowserEvents')
ev.on_event {|*args| default_handler(*args)}

$LOOP = TRUE
@poll = Time.now + 2
while ($LOOP)
  WIN32OLE_EVENT.message_loop
  if $LISTEN
    now = Time.now
    if now > @poll
        new_url = fetch_url($SERVER)
        if $current != new_url
          puts "IE navigates to: #{new_url}"
          ie.navigate($current = new_url)
        end
        @poll = now + 2
    end
  end
end

puts "You Navigated the URLs ..."
$urls.each_with_index do |url, i|
  puts "(#{i+1}) #{url}"
end

