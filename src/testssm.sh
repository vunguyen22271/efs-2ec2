script=$(cat myscript.ps1)
response=$(aws ssm send-command \
    --document-name "AWS-RunPowerShellScript" \
    --document-version "1" \
    --parameters '{"workingDirectory":[""],"executionTimeout":["3600"],"commands":["'"$script"'"]}' \
    --timeout-seconds 600 \
    --max-concurrency "50" \
    --max-errors "0" \
    --region us-east-1 \
    --instance-ids "i-0050085d9aa80009c")

command_id=$(echo "$response" | jq -r '.Command.CommandId')

aws ssm wait command-executed \
    --command-id $command_id \
    --instance-id 'i-0050085d9aa80009c'

response=$(aws ssm get-command-invocation \
    --command-id $command_id \
    --instance-id 'i-0050085d9aa80009c')
echo $response