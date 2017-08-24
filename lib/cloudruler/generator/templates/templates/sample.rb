description 'This is a sample template.'

vpc = ruler :vpc do
  @cidr = '10.0.0.0/16'
  @tag = 'sample-vpc'
end

ruler :subnet do
  @vpc = vpc.resources.vpc
  @availability_zone = 'ap-northeast-1'
  @cidr = '10.0.1.0/24'
  @tag = 'sample-subnet'
end
