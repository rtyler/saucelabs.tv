

module FakeData
  def jobs
    jobs = []
    10.times do |i|
      jobs << {'id' => "cuke-#{i}",
              'name' => "Cucumber Job #{i}",
              'end_time' => 30,
              'start_time' => 20}
    end
    jobs
  end
end

World(FakeData)
