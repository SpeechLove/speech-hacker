desc 'Pretty print out all defined routes in match order, with names. Target specific controller with CONTROLLER=x.'

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
  controller.split("_").collect do |name|
    name.capitalize
  end.join("_").split("/").collect do |name|
    name.capitalize
  end.join("/")
end

task :clean_routes => :environment do
  if all_routes = ENV['CONTROLLER']
    all_routes = SpeechHacker::Application.routes.select do |route|
      route.defaults[:controller] == ENV['CONTROLLER']
    end
  else
    all_routes = SpeechHacker::Application.routes
  end
  routes = all_routes.set.collect do |route|
    reqs = route.requirements.empty? ? "" : route.requirements.inspect
    {:name => route.name, :verb => route.verb, :path => route.path, :reqs => reqs}
  end

  grouped_routes = routes.each do |r|
    r[:reqs] = reqs_to_hash(r[:reqs])
    r[:verb] = r[:verb].to_s.delete "mix\$\^\:\?\(\)\-"
    r[:path] = r[:path].spec
  end.group_by { |r| r[:reqs][:controller] }

  grouped_routes.each_key do |controller|
    if controller
      puts ""
      puts controller_name(controller)
    else
      puts "NO NAME"
    end
    grouped_routes[controller].each do |route|
      if route[:name]
        print "|- "
      else
        print "|  "
      end
      puts ["#{route[:name].to_s}".ljust(25),
            "#{route[:verb].to_s}".ljust(10),
            "#{route[:path].to_s}".ljust(35),
            "#{route[:reqs][:controller]}##{route[:reqs][:action]}".ljust(30)].join
    end
  end

end