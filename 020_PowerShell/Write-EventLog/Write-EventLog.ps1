#----------------------------------------------------------------
# Name        : Write-EventLog.ps1
# Version     : 1.00
# Description : Widnows�C�x���g���O�̏������݂��s���T���v���X�N���v�g�B
# Author      : rogasawara
# Date        : 2020-01-25
#----------------------------------------------------------------

#----------------------------------------------------------------
# Main����
#----------------------------------------------------------------
# �j���̎擾(0:���A1:���A2:�΁A3:���A4:�؁A5:���A6:�y)
$DayOfWeek=$(Get-Date).DayOfWeek.value__

if($DayOfWeek -eq 0){

    # �G���[���O�̏o��
    Write-EventLog -LogName Application -EntryType Error -Source Write-EventLog.ps1 -EventId 102 -Message "���j���́A��ғ����ł��B"   
    Write-Host "�G���[���O���o�͂��܂����I�I�I"
    
} elseif($DayOfWeek -eq 6){

    # ���[�j���O���O�̏o��
    Write-EventLog -LogName Application -EntryType Warning  -Source Write-EventLog.ps1 -EventId 101 -Message "�y�j���́A���x�ł��B" 
    Write-Host "���[�j���O���O���o�͂��܂����I�I�I"
    
} else {

    # ���탍�O�̏o��
    Write-EventLog -LogName Application -EntryType SuccessAudit -Source Write-EventLog.ps1 -EventId 100 -Message "�����́A�ғ����ł��B"
    Write-Host "���탍�O���o�͂��܂����I�I�I"

}
