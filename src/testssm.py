import boto3
import json
import datetime
# ec2 = boto3.client('ssm',region_name='us-east-2', aws_access_key_id='XXXXXXXXX',aws_secret_access_key='XXXXXXXXXXXXXXXXXXX')

ssm_client = boto3.client('ssm',region_name='us-east-1')
ssm_response = ssm_client.send_command( InstanceIds=["i-0050085d9aa80009c"],
                                        DocumentName='AWS-RunPowerShellScript',
                                        Parameters={"commands": ["hostname"]})

ssm_response['Command']['RequestedDateTime'] = ssm_response['Command']['RequestedDateTime'].strftime('%Y-%m-%d %H:%M:%S')  # Convert datetime to string
ssm_response['Command']['ExpiresAfter'] = ssm_response['Command']['ExpiresAfter'].strftime('%Y-%m-%d %H:%M:%S')  # Convert datetime to string

print(json.dumps(ssm_response, indent=2))

command_id = ssm_response['Command']['CommandId']

output = ssm_client.get_waiter('command_executed').wait(
        CommandId=command_id,
        InstanceId='i-0050085d9aa80009c'  
        )
print(output)

output = ssm_client.get_command_invocation(
            CommandId=command_id,
            InstanceId='i-0050085d9aa80009c',
        )
print(json.dumps(output, indent=2))