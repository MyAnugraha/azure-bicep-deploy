# azure-bicep-deploy
Used to deploy Azure resources using bicep templates
## What is Bicep?
Bicep is Iac which has declarative syntax to deploy azure resources. It is domain specific language not the programming language for writing applications.Bicep will create Resource Manager Template (ARM Templates) in the background.
## Benefits:
Simple syntax - parameters, variables, strings are used to make our templates easy and reusable.

Bicep templates converted into JSON templates during deployment. This process called "transpilation"

we can view JSON template by running the command "bicep build. This command automatically converts bicep file into ARM template.

Finally, Bicep template contains less code, easier to read and understand than the ARM templates. That is why Bicep came into picture.
