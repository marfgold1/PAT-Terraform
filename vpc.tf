resource "aws_vpc" "default" {
    cidr_block = "10.32.0.0/16"
}

resource "aws_subnet" "public" {
    count = 2
    cidr_block = cidrsubnet(aws_vpc.default.cidr_block, 8, 2 + count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]
    vpc_id = aws_vpc.default.id
    map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
    count = 2
    cidr_block = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]
    vpc_id = aws_vpc.default.id
}
