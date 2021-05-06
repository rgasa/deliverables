# --------------------------------------------------------------------
# Name          : Delete-Import.ps1
# Version       : 1.00
# Description   : �e�[�u���폜��Import�����B
# Author        : rogasawara
# Date          : 2021-04-20
# Update        :
# --------------------------------------------------------------------

# script���̎擾
$ScriptName = $MyInvocation.MyCommand.name
# �J�����g�f�B���N�g���̃Z�b�g
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);
# �J�����g�f�B���N�g���̎擾
$CurrentDir = $(Get-Location);

# Env�t�@�C���̓Ǎ�
.".\Env.ps1"

# �A�Z���u���̃��[�h
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
# �ڑ�������̐���
[string]$MySqlConnectionString = "server='$RmtDbHost';port='$RmtDbPort';uid='$RmtDbUser';pwd=$RmtDbPassword;database=$RmtDb;allowLoadLocalInfile=true; "

# �R�l�N�V�����̐���
$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
$Connection.ConnectionString = $MySqlConnectionString

try {
    # MySql�֐ڑ�
    $Connection.Open()

    $Msg = "�����[�g�f�[�^�x�[�X�ڑ�OK...!!!"
    Write-Host "$Msg"
    # �e�L�X�g���O�̏o��
    Write-Log $Msg $ScriptName

    # DELETE���s
    [string]$DeleteStr = "DELETE FROM ms_admin_user;"
    $DeleteCmd = New-Object MySql.Data.MySqlClient.MySqlCommand($DeleteStr,$Connection)
    $Result = $DeleteCmd.ExecuteNonQuery()

    $Msg = "TABLE DELETE OK...!!!"
    # ��ʂւ̃��b�Z�[�W�\��
    Write-Host "$Msg"
    # �e�L�X�g���O�̏o��
    Write-Log $Msg $ScriptName

    # CSV�̃C���|�[�g
    [string]$LoadStr = "LOAD DATA LOCAL INFILE `"C:\\@workspace\\416_PowerShell\\001_MySql-Select-Insert\\tmp.csv`" INTO TABLE ms_admin_user FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '`"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES ;"
    $LoadCmd = New-Object MySql.Data.MySqlClient.MySqlCommand($LoadStr, $Connection)
    $Result = $LoadCmd.ExecuteNonQuery()
    
    $Msg = "CSV IMPORT OK !!! ..."
    # ��ʂւ̃��b�Z�[�W�\��
    Write-Host "$Msg"
    # �e�L�X�g���O�̏o��
    Write-Log $Msg $ScriptName

} catch {

    $Msg = $Error[0].exception;
    # �G���[���O�̏o��
    Write-Host $Msg ;
    # �e�L�X�g���O�̏o��
    Write-Log $Msg $ScriptName

} finally {

    $Connection.Close()

}