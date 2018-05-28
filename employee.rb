
class Employee
  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    boss.employees << self if boss
  end

  def bonus(multiplier)
  end
  
  attr_reader :name, :title, :salary, :boss
end

class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss)
    @employees = []
  end
  
  def bonus(multiplier)
    sum = 0
    
    employees.each do |employee|
      sum += employee.salary
      if employee.is_a? Manager
        sum += employee.bonus(1)
      end
    end
    
    sum * multiplier
  end
end

class NonManager < Employee
  def bonus(multiplier)
    salary * multiplier
  end
end

ned = Manager.new("Ned", "Founder", 1_000_000)
darren = Manager.new("Darren", "TA Manager", 78_000, ned)
shawna = NonManager.new("Shawna", "TA", 12_000, darren)
david = NonManager.new("David", "TA", 10_000, darren) 

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000