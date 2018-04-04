Param(
  [string]$sourceBranch
)


#step 1: tag the build based on branch name


$branchName= $sourceBranch.Substring(11)
$addTag = "##vso[build.addbuildtag]"

If ($branchName -like "master")
{Write-Host $addTag"prod"}

If ($branchName -like "deploy/dev*")
{Write-Host $addTag"dev"}

If ($branchName -like "deploy/tst*")
{Write-Host $addTag"tst"}

If ($branchName -like "deploy/tst1*")
{Write-Host $addTag"tst1"}

If ($branchName -like "deploy/tst2*")
{Write-Host $addTag"tst2"}

If ($branchName -like "deploy/tst3*")
{Write-Host $addTag"tst3"}

If ($branchName -like "deploy/tst4*")
{Write-Host $addTag"tst4"}

If ($branchName -like "deploy/tst5*")
{Write-Host $addTag"tst5"}




#step 2: tag the build based on the last git tag.


$tag = git tag


# support multiple tags , as they would come as array
if (  ($tag -is [system.array] ) -and ( $tag.Count -gt 0)) 
{
    # we are only interested on the last tag.
    $tag = $tag[$tag.Count -1]
}

# the previous if is suppose to convert array onto string
# however maybe you have only one single tag e.g.the first ever tag for your code
if ( $tag -is [system.string])
{
    if ( $tag -like "deploy:*")
    {
        $environment = $tag.ToLower().Replace("deploy:", "")
        $addTagCode = "##vso[build.addbuildtag]" + $environment
        Write-Host $addTagCode
    } 


}
 
