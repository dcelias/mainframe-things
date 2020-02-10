#!/usr/bin/#!/usr/bin/env groovy
import hudson.model.*
import hudson.EnvVars
import hudson.Launcher
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL
 
// Integracao com o CES e HCI
String HCI_Connection     = "tcpeca.itau:16196"
String CES_Connection     = "tcpeca.itau:48226"
String HCI_ID             = "162c284f-6201-4c96-866b-98739dffa04c"
String COBOL              = "cbl"
String JCL                = "jcl"
 
// Integracao com o JENKINS
String Jenkins_Id         = "f38c8497-c332-45d2-a41e-4fd57fbe4e5b"  // JENKINS TOKEN COM O RACF/SENHA DO SECA (ELIADIE)
 
// Integracao com o GITLAB
String github_credentials = "92e98efa-7f2a-4841-a8fb-39d429ab0148"  // Usuário e senha do GitLab mas gerado no Jenkins
String github_token       = "2aHynN-x6J82bHWiCz-Q"                  // Usuario e senha gerado no GitLab
String github_url         = "https://gitcorp.prod.cloud.ihf/eliadie/testes-mainframe.git" // The github URL com o repositorio onde estao os projetos de teste
String git_commit         = "https://oauth2:" + github_token + "gitcorp.prod.cloud.ihf/eliadie/testes-mainframe.git" 


String JENKINS_Path       = "/root/Install/jenkins_wrk/POC_CWPR_1/TopazCliWkspc"
String SOURCE_Path        = "/root/Install/jenkins_wrk/POC_CWPR_1/MF_Source"
 
// Integracao com o CHANGEMAN
String CHG_amb            = "LAB"          // Ambiente ChangeMan (Datasets)     - LAB: Laboratorio; RLS: Release; MAN: Producao   *ALTERAR
String CHG_subsys         = "A"            // Ambiente ChangeMan (XML Services) - A  : Laboratorio; R  : Release; 1  : Producao   *ALTERAR
String CHG_appl           = "ZI0I"         // Aplicacao ChangeMan                                                                 *ALTERAR
String CHG_npkg           = "001112"       // Numero do pacote ChangeMan                                                          *ALTERAR
String CHG_comp           = "ZIB0T01"      // Nome do Componente                                                                  *ALTERAR
String CHG_ltype          = "SRC"          // Tipo do componente                                                                  *ALTERAR
String CHG_cics           = "N"            // Usado para verificar se o componente é CICS ou não                                  *ALTERAR
String CHG_source         = 'DESICBIB.CHG' + CHG_amb + '.STG.' + CHG_appl + '.#' + CHG_npkg + '.' + CHG_ltype 

 
// Integracao com o TOPAZ FOR TOTAL TEST (TTT)
String TTT_Project        = "ZI0BT01_TTT"       // Nome do projeto de teste
String TTT_TestPackage    = "ZI0BT01_Scenario"  // Nome do cenario de teste
String TTT_PackageType    = ".testscenario"     // sufixo do cenario de teste
String TTT_Jcl            = "Runner.jcl"        // Nome do JCL que executa o TTT
String TTT_Dir            = "TTTUnit"           // Nome da pasta com o resultado dos testes que sera gravado no Jenkins
String TTT_Sonar          = "TTTSonar"          // Nome da pasta passada ao SonarScanner 
 
// Integracao com o XPEDITER CODE COVERAGE
if  (CHG_cics   = "S") { 
     String CC_repo       = "SYSC.XPEDCICS.REPOSIT"
     String CC_ddio       = "BIBCADES.COMPWARE.SRCCIC01"

}   else{ 
     String CC_repo       = "SYSC.XPEDTSO.REPOSIT"
     String CC_ddio       = "BIBCADES.COMPWARE.SRCBAT01"
}

String CC_properties      = 'cc.sources='          + CHG_source + 
                            '\rcc.repos='          + CC_repo +
                            '\rcc.system='         + CHG_appl +
                            '\rcc.test='           + CHG_comp + 
                            '\rcc.ddio.overrides=' + CC_ddio
                                                                       
// SonarQube ID usado para o Project Key e para o Project Name dentro
String SQ_Project         = CHG_appl


stage("Build no ChangeMan (Pendente) *")
{
    node 
    {
        // Working Progress
    }
}
 
stage("Promote no ChangeMan (Pendente) * ")
{
    node
    {
        // Working Progress
    }
}
 
stage("Executar Testes Unitários")
{
    node
    {
                            //Download the test from github
                                         checkout changelog: false, 
                                                       poll: false, 
                                                       scm: [$class: 'GitSCM', 
                                                       branches: [[name: '*/master']], 
                                                       doGenerateSubmoduleConfigurations: false, 
                                                       extensions: [], 
                                                       submoduleCfg: [], 
                                                       userRemoteConfigs: 
                                                                     [[credentialsId: github_credentials, 
                                                                     name: 'origin', 
                                                                     url: github_url]]]
    }

    node
    {
                                         //            Run Total Test Jenkins Plugin
                                                       step([$class: 'TotalTestBuilder', 
                                                       ccRepo:                            "${CC_repo}",
                                                       ccSystem:                          "${CHG_appl}", 
                                                       ccTestId:                          "${CHG_comp}", 
                                                       connectionId:                      "${HCI_ID}", 
                                                       credentialsId:                     "${Jenkins_Id}", 
                                                       deleteTemp:                         true, 
                                                       hlq:                                '',
                                                       jcl:                               "${TTT_Jcl}", 
                                                       projectFolder:                     "${TTT_Project}", 
                                                       testSuite:                         "${TTT_TestPackage}${TTT_PackageType}", 
                                                       useStubs:                           true])
        
                                         //            Process the Total Test result files into Jenkins
                                                       junit keepLongStdio: true, testResults: "${TTT_Dir}/*.xml"
    }
    
}
 
stage("Resultados da Cobertura de Código")
{
    node
    {
                                         //Download the Source From PDSe do ChangeMan
                                         checkout([
                                         $class: 'PdsConfiguration', 
                                         connectionId: HCI_ID, 
                                         credentialsId: Jenkins_Id, 
                                         fileExtension: COBOL, 
                                         filterPattern: CHG_source, 
                                         targetFolder: ''
                                         ])
    }
}
 
    node
    {
                                         // Retrieve Code Coverage Data
                                                       step([
                                                                     $class: 'CodeCoverageBuilder',
                                                                     analysisProperties:               CC_properties,
                                                                     analysisPropertiesPath: '',
                                                                     connectionId:                               "${HCI_ID}",
                                                                     credentialsId:                                Jenkins_Id
                                                                     ])
    }


stage("SonarQube Analysis") 
{
    node
    {
                                         // Requires SonarQube Scanner 2.8+
                                                       def scannerHome = tool 'scanner';
                                                       withSonarQubeEnv('sonar.ctsp.des.cloud.ihf') 
                                                       {
                                                       // Run SonarQube Scanner 
                                                                     def SQ_Tests                = " -Dsonar.tests=${TTT_Project} -Dsonar.testExecutionReportPaths=${TTT_Sonar}/${TTT_TestPackage}.xml -Dsonar.coverageReportPaths=Coverage/CodeCoverage.xml"
                                                                     def SQ_ProjectKey           = " -Dsonar.projectKey=${SQ_Project} -Dsonar.projectName=${SQ_Project} -Dsonar.projectVersion=1.0"
                                                                     def SQ_Source               = " -Dsonar.sources=${CHG_source}"
                                                                     def SQ_Copybook             = " -Dsonar.cobol.copy.directories=${CHG_source}"
                                                                     def SQ_Cobol_conf           = " -Dsonar.cobol.file.suffixes=cbl,testsuite,testscenario,stub -Dsonar.cobol.copy.suffixes=cpy -Dsonar.sourceEncoding=UTF-8"
                                                                     sh "${scannerHome}/sonar-scanner -X" + SQ_Tests + SQ_ProjectKey + SQ_Source + SQ_Copybook + SQ_Cobol_conf 
                                                       }
    }
}

stage("Check Quality Gate")
{
    node
    { 
                                         timeout(time: 5, unit: 'MINUTES') 
                                         {
                                                       // Wait for webhook call back from SonarQube
                                                                     withSonarQubeEnv('sonar.ctsp.des.cloud.ihf') {
                                                                     def qg = waitForQualityGate()
                                                                     if (qg.status != 'OK')
                                                                                   {
                                                                                   echo "Pipeline aborted due to quality gate failure: ${qg.status}"
                                                                                  // If the quality gate is anything other than Green, regress the promoted code
                                                                                   // Define variables to be used to call CHANGEMAN
                                                                                   // Call CHANGEMAN Operation
                                                                                   error "Exiting Pipeline"
                                                                                   }
                                                                     else
                                                                                   {
                                                                                   echo "Quality Gate status is: {${qg.status}"
                                                                                   }


                                                                     }

                                         }   
    }
}