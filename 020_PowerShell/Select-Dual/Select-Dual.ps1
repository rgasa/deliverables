# ----------------------------------------------------------
# Main����
# ----------------------------------------------------------
# �J�����g�f�B���N�g���̃Z�b�g
Set-Location $(Split-Path $MyInvocation.MyCommand.Path -Parent)

# �A�Z���u���̃��[�h
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Data.OracleClient")

# �R�l�N�V�����̐���
$oracleConStr = "Data Source=orcl;User ID=ora01;Password=ora01;Integrated Security=false;"
$oracleCon    = New-Object System.Data.OracleClient.OracleConnection($oracleConStr)

# �C���X�^���X�̏�����
$oracleCmd = New-Object System.Data.OracleClient.OracleCommand
$oracleCmd.Connection = $oracleCon

# DB�ڑ�
$oracleCon.open();

# SQL���̎w��
$oracleCmd.CommandText = "select 'hoge' from dual"

# SQL���̎��s
$oracleDataReader = $oracleCmd.ExecuteReader()

# ���s���ʂ��擾
try {

    while($oracleDataReader.Read()){
        Write-Host ("column = [" + $oracleDataReader.GetString(0) + "]")
    }
    
} finally {
    $oracleDataReader.Close()
}
$oracleCmd.Dispose()
$oracleCon.Close()
$oracleCon.Dispose()
