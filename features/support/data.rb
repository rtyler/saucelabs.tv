

module FakeData
  def jobs
    jobs = []
    10.times do |i|
      jobs << {'id' => "cuke-#{i}",
              'name' => "Cucumber Job #{i}"}
    end
    jobs
  end
end

World(FakeData)
