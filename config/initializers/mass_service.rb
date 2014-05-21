class MassService
  def self.run(requests, start_date, finish_date)
    days_count = (finish_date - start_date).to_i+1
    hours_count = days_count==0 ? 8 : days_count*8
    lambda = requests.count*1.0/hours_count
    n = lambda.round(0) == 0 ? 1 : lambda.round(0)
    mu = self.calculate_mu(requests)
    ro = lambda/mu
    piN = ((1-ro)/(1-(ro**(n+1))))*(ro**n)
    em = self.calculate_m(ro, n)
    w1 = em/(lambda*(1-piN))

    {requests_count: requests.count, days_count: days_count, hours_count: hours_count, lambda: lambda, mu: mu, ro: ro, piN: piN, em: em, w1: w1 }
  end

  def self.calculate_mu(requests)
    sum_of_time = 0
    count = 0
    requests.each do |request|
      sum_of_time += (request.finish - request.start)/60
      count+=1
    end
    return 60/(sum_of_time/count)
  end

  def self.calculate_m(ro, n)
    if ro == 1
      return n/2
    else
      top = ro*(1-(n+1)*(ro**n)+ n*(ro**(n+1)))
      bottom = (1-(ro**(n+1)))*(1-ro)
      m = top/bottom
      return m
    end
  end
end