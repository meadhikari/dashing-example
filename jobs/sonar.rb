require 'net/http'
require 'json'
 
id = "id" 
SCHEDULER.every '10s', :first_in => 0 do |job|
    uri = URI("http://countdown.tfl.gov.uk/stopBoard/49741")
	res = Net::HTTP.get(uri)
	j = JSON[res]['arrivals']
 	times = []
 	$i = 0
	length = j.length
	while $i < length  do
		if j[$i]["destination"] == "Willesden Gar"
  			times.push(j[$i]['estimatedWait'])
  			$i +=1
  		end
	end
	send_event(id, { items: 
		[{ label: 'First', value: times[0] },
		{label:'Second', value:times[1]},
		{label:'Third', value:times[2]}
		]})
end


