function cdk --wraps='pnpm dlx aws-cdk' --description 'alias cdk=pnpm dlx aws-cdk'
    pnpm dlx aws-cdk $argv
end
