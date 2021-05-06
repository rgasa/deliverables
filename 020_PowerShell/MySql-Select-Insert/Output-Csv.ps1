# --------------------------------------------------------------------
# Name          : Output-Csv.ps1
# Version       : 1.00
# Description   : �f�[�^�A�g�̃��C�������B
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
[string]$MySqlConnectionString = "server='$SrcDbHost';port='$SrcDbPort';uid='$SrcDbUser';pwd=$SrcDbPassword;database=$SrcDb"

# �R�l�N�V�����̐���
$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
$Connection.ConnectionString = $MySqlConnectionString

try {
    # MySql�֐ڑ�
    $Connection.Open()
    $Msg = "�\�[�X�f�[�^�x�[�X�ڑ�OK...!!!"

    # ��ʂւ̃��b�Z�[�W�\��
    Write-Host $Msg 
    # �e�L�X�g���O�̏o��
    Write-Log $Msg $ScriptName

    # SQL���s
    $Command = $Connection.CreateCommand()
    $Command.CommandText = 'SELECT user_id, name FROM ms_user'
    $Result = $Command.ExecuteReader()

    $Msg = "SQL���sOK...!!!"
    # ��ʂւ̃��b�Z�[�W�\��
    Write-Host $Msg
    # �e�L�X�g���O�̏o��
    Write-Log $Msg $ScriptName

    # Datatable�Ƀf�[�^���Z�b�g
    $DataTable = New-Object "System.Data.Datatable"
    $DataTable.Load($Result)
    # $DataTable | Format-Table

    $DataTable | Export-Csv $path".\tmp.csv" -Delimiter "," -encoding "UTF8" -notype

    $Msg = "CSV�o��OK...!!!"
    # ��ʂւ̃��b�Z�[�W�\��
    Write-Host $Msg
    # �e�L�X�g���O�̏o��
    Write-Log $Msg $ScriptName

} catch {

    $Msg = $Error[0].exception;
    # ��ʂւ̃��b�Z�[�W�\��
    Write-Host $Msg
    # �e�L�X�g���O�̏o��
    Write-Log $Msg $ScriptName

} finally {
    # �R�l�N�V�����N���[�Y
    $Connection.Close()
}
