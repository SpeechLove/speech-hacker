# this is a new rake task that is the equivalent of
# rake routes, except that it's formatted and grouped by controller.
# you can call this task with the command 'rake clean_routes'

task :clean_routes => :environment do
  print_routes
end

def print_routes
  grouped_routes.each_key do |controller|
    puts controller_name(controller)

    grouped_routes[controller].each do |route|
      print left_indent(route[:name])
      puts ["#{route[:name].to_s}".ljust(25),
            "#{route[:verb].to_s}".ljust(10),
            "#{route[:path].to_s}".ljust(35),
            "#{route[:reqs][:controller]}##{route[:reqs][:action]}".ljust(30)].join
    end
  end
end

def grouped_routes
  g_routes = get_all_routes.set.collect do |route|
    {:name => route.name,
     :verb => verb_action(route.verb),
     :path => route.path.spec,
     :reqs => route_reqs(route)
   }
  end.group_by { |r| r[:reqs][:controller] }
  g_routes
end

def get_all_routes
  if all_routes = ENV['CONTROLLER']
    all_routes = SpeechHacker::Application.routes.select do |route|
      route.defaults[:controller] == ENV['CONTROLLER']
    end
  else
    all_routes = SpeechHacker::Application.routes
  end
  all_routes
end

def verb_action(verb)
  verb.to_s.delete "mix\$\^\:\?\(\)\-"
end

def route_reqs(route)
  route.requirements.empty? ? reqs = "" : reqs = route.requirements.inspect
  reqs_to_hash(reqs)
end

def reqs_to_hash(reqs)
  if reqs.include?("=>")
    r_params = (reqs.delete "\\\"{},:").split(" ")
    first = r_params[0].split("=>")
    first[0] == "controller" ? con = first[1] : act = first[1]
    second = r_params[1].split("=>")
    second[0] == "action" ? act = second[1] : con = second[1]
    {:controller => con, :action => act}
  else
    {:controller => reqs}
  end
end

def controller_name(controller)
  controller ? name = controller : name = "no name"
  capitalized_name(name)
end

def capitalized_name(name)
  c_name = name
  ["/", "_"].each do |separator|
    c_name = c_name.split(separator).each do |n|
      n[0] = n[0].upcase
    end.join(separator)
  end
  c_name
end

def left_indent(has_name)
  has_name ? "|- " : "|  "
end