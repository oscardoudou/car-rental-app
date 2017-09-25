task :cancel_reservation_30mins => :environment do
  begin
    Reservation.where("checkout_time < ? and status = ?", (Time.now-30.minutes).to_s, 'reserved').update_all(:status => 'cancled')
  end

end

