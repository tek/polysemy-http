#!/usr/bin/env bash

orig_file=$1 in_file=$2 out_file=$3

cat > $out_file <<EOF
{-# LANGUAGE AllowAmbiguousTypes, ApplicativeDo, BangPatterns, BinaryLiterals, ConstraintKinds, DataKinds, DefaultSignatures, DeriveAnyClass, DeriveDataTypeable, DeriveFoldable, DeriveFunctor, DeriveGeneric, DeriveTraversable, DerivingVia, DoAndIfThenElse, EmptyDataDecls, ExistentialQuantification, FlexibleContexts, FlexibleInstances, FunctionalDependencies, GADTs, GeneralizedNewtypeDeriving, InstanceSigs, KindSignatures, LambdaCase, MultiParamTypeClasses, MultiWayIf, NamedFieldPuns, OverloadedStrings, PackageImports, PartialTypeSignatures, PatternGuards, PatternSynonyms, PolyKinds, QuantifiedConstraints, QuasiQuotes, RankNTypes, RecordWildCards, RecursiveDo, ScopedTypeVariables, StandaloneDeriving, TemplateHaskell, TupleSections, TypeApplications, TypeFamilies, TypeOperators, TypeSynonymInstances, UndecidableInstances, UnicodeSyntax, ViewPatterns #-}
{-# OPTIONS_GHC -fplugin=Polysemy.Plugin #-}
{-# LINE 1 "$orig_file" #-}
EOF

cat $in_file >> $out_file
