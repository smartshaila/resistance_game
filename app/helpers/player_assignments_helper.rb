module PlayerAssignmentsHelper
  def scoreboard_table game
    capacities = ([['Mission #', 'Capacity', 'Rejected Teams', 'Result']] | game.mission_capacities.map{|c|
      mission = game.missions.where(mission_number: c.mission_number).first
      [c.mission_number + 1, c.capacity.to_s + (c.fail_count > 1 ? "<sup> [#{c.fail_count}]</sup>" : ""), (mission.rejection_count unless mission.nil?), ("<span class='#{(mission.result.nil? ? 'glyphicon glyphicon-time' : (mission.result ? 'glyphicon glyphicon-ok' : 'glyphicon glyphicon-remove'))}'></span>" unless mission.nil?)]
    }).transpose
    header = capacities.first
    capacities = capacities[1..-1]
    html = "<table class='table table-striped table-bordered'><thead><tr><th>#{header.join('</th><th>')}</th></tr></thead><tbody>"
    capacities.each do |c|
      html += "<tr><td>#{c.join('</td><td>')}</td></tr>"
    end
    html += "</tbody></table>"
    html.html_safe
  end
end
