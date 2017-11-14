//
// Copyright (c) 2010-2017 Antmicro
//
// This file is licensed under the MIT License.
// Full license text is available in 'licenses/MIT.txt'.
//
using System;

namespace Antmicro.Renode.PlatformDescription.Syntax
{
    public interface ISimplestValue
    {
        object ConvertedValue { get; }
    }
}
