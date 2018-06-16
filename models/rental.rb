require_relative('../db/sql_runner')

class Rental

  attr_reader :id, :tank_id, :customer_id

  def initialize( options )
    @id = options['id'].to_i
    @tank_id = options['tank_id'].to_i
    @customer_id = options['customer_id'].to_i
  end

  def save()
      sql = "INSERT INTO rentals
      (
        customer_id,
        tank_id
      )
      VALUES
      (
        $1, $2
      )
      RETURNING *"
      values = [@customer_id, @tank_id]
      rental_data = SqlRunner.run(sql, values)
      @id =   rental_data.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM rentals"
    rentals = SqlRunner.run( sql )
    result = rentals.map { |rental| Rental.new( rental ) }
    return result
  end

end
