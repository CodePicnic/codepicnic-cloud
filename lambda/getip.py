import boto3

config_sg_swarm = "sg-33871c4b"
config_sg_deploy = "sg-0671fe7e"

def lambda_handler(event, context):
    source_ip = event['source_ip']
    client = boto3.client('ec2')
    source_ip_list = list()
    source_ip_list.append({ 'CidrIp': source_ip+"/32" })
    add_params = {
            'ToPort': 65535,
            'FromPort': 21,
            'IpRanges': source_ip_list,
            'IpProtocol': "tcp"
        }
    client.authorize_security_group_ingress(GroupId=config_sg_swarm, IpPermissions=[add_params])
    client.authorize_security_group_ingress(GroupId=config_sg_deploy, IpPermissions=[add_params])

    return {"ip": source_ip}

