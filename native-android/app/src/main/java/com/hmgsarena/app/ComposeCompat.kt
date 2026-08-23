package com.hmgsarena.app

import androidx.compose.runtime.Composable

@Composable
fun <T> rememberSaveable(calculation: () -> T): T =
    androidx.compose.runtime.saveable.rememberSaveable(init = calculation)
