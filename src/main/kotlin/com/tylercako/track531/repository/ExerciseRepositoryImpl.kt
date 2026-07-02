package com.tylercako.track531.repository

import com.tylercako.track531.model.db.Exercise
import org.springframework.jdbc.core.JdbcTemplate

class ExerciseRepositoryImpl(private val jdbcTemplate: JdbcTemplate) : ExerciseRepository {

    override fun findById(id: String): Exercise? {
        return TODO("Provide the return value")
    }
        //return jdbcTemplate.query("select * from exercise where id = ?", arrayOf(id), Exercise::class.java)
    //}

    override fun findByUserId(userId: String): List<Exercise> {
        return TODO("Provide the return value")
    }
}